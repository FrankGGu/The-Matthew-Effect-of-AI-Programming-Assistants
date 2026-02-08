import heapq
from collections import defaultdict

class MovieRentingSystem:

    def __init__(self, n: int, entries: List[List[int]]):
        self.available = defaultdict(dict)  # shop -> movie -> price
        self.movie_to_shops = defaultdict(list)  # movie -> list of (price, shop)
        self.rented = []  # heap of (price, shop, movie)
        self.rented_set = set()  # (shop, movie)

        for shop, movie, price in entries:
            self.available[shop][movie] = price
            heapq.heappush(self.movie_to_shops[movie], (price, shop))

    def search(self, movie: int) -> List[int]:
        res = []
        temp_heap = []
        while self.movie_to_shops[movie] and len(res) < 5:
            price, shop = heapq.heappop(self.movie_to_shops[movie])
            if (shop, movie) not in self.rented_set:
                res.append(shop)
            temp_heap.append((price, shop))
        for price, shop in temp_heap:
            heapq.heappush(self.movie_to_shops[movie], (price, shop))
        return res

    def rent(self, shop: int, movie: int) -> None:
        price = self.available[shop][movie]
        self.rented_set.add((shop, movie))
        heapq.heappush(self.rented, (price, shop, movie))

    def drop(self, shop: int, movie: int) -> None:
        self.rented_set.remove((shop, movie))

    def report(self) -> List[List[int]]:
        res = []
        temp = []
        while self.rented and len(res) < 5:
            price, shop, movie = heapq.heappop(self.rented)
            if (shop, movie) in self.rented_set:
                res.append([shop, movie])
            temp.append((price, shop, movie))
        for item in temp:
            heapq.heappush(self.rented, item)
        return res