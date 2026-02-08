import heapq
from collections import defaultdict

class MovieRentalSystem:

    def __init__(self, n: int, entries: list[list[int]]):
        self.prices = {}  # (shop, movie) -> price

        # For available movies:
        # movie_id -> min-heap of (price, shop_id)
        self.available_heaps = defaultdict(list) 
        # (shop_id, movie_id) for quick check if a movie is truly available
        self.is_available_tuple = set() 

        # For rented movies:
        # min-heap of (price, shop_id, movie_id)
        self.rented_heap = [] 
        # (shop_id, movie_id) for quick check if a movie is truly rented
        self.is_rented_tuple = set() 

        for shop, movie, price in entries:
            self.prices[(shop, movie)] = price
            heapq.heappush(self.available_heaps[movie], (price, shop))
            self.is_available_tuple.add((shop, movie))

    def search(self, movie: int) -> list[list[int]]:
        result = []
        temp_popped = []

        movie_heap = self.available_heaps[movie]

        while len(result) < 5 and movie_heap:
            price, shop = heapq.heappop(movie_heap)
            if (shop, movie) in self.is_available_tuple:
                result.append([shop])
                temp_popped.append((price, shop))

        # Push back the valid items that were popped to maintain heap state
        for item in temp_popped:
            heapq.heappush(movie_heap, item)

        return result

    def rent(self, shop: int, movie: int) -> None:
        price = self.prices[(shop, movie)]

        # Mark as unavailable
        self.is_available_tuple.remove((shop, movie))

        # Mark as rented and add to rented heap
        heapq.heappush(self.rented_heap, (price, shop, movie))
        self.is_rented_tuple.add((shop, movie))

    def drop(self, shop: int, movie: int) -> None:
        price = self.prices[(shop, movie)]

        # Mark as available
        self.is_available_tuple.add((shop, movie))
        # Add to available heap (lazy addition, actual removal from heap happens during search)
        heapq.heappush(self.available_heaps[movie], (price, shop))

        # Mark as not rented
        self.is_rented_tuple.remove((shop, movie))

    def report(self) -> list[list[int]]:
        result = []
        temp_popped = []

        while len(result) < 5 and self.rented_heap:
            price, shop, movie = heapq.heappop(self.rented_heap)
            if (shop, movie) in self.is_rented_tuple:
                result.append([shop, movie])
                temp_popped.append((price, shop, movie))

        # Push back the valid items that were popped to maintain heap state
        for item in temp_popped:
            heapq.heappush(self.rented_heap, item)

        return result