class MovieRentingSystem:

    def __init__(self, n: int, entries: list[list[int]]):
        self.prices = {}
        self.rented = set()
        self.movies_by_shop = {}
        self.shops_by_movie = {}

        for shop, movie, price in entries:
            self.prices[(shop, movie)] = price
            if shop not in self.movies_by_shop:
                self.movies_by_shop[shop] = []
            self.movies_by_shop[shop].append(movie)
            if movie not in self.shops_by_movie:
                self.shops_by_movie[movie] = []
            self.shops_by_movie[movie].append(shop)

    def search(self, movie: int) -> list[int]:
        if movie not in self.shops_by_movie:
            return []

        available_shops = []
        for shop in self.shops_by_movie[movie]:
            available_shops.append((self.prices[(shop, movie)], shop))

        available_shops.sort()

        result = []
        for price, shop in available_shops[:5]:
            result.append(shop)

        return result

    def rent(self, shop: int, movie: int) -> None:
        self.rented.add((shop, movie))

    def drop(self, shop: int, movie: int) -> None:
        self.rented.remove((shop, movie))

    def report(self) -> list[list[int]]:
        rented_movies = []
        for shop, movie in self.rented:
            rented_movies.append((self.prices[(shop, movie)], shop, movie))

        rented_movies.sort()

        result = []
        for price, shop, movie in rented_movies[:5]:
            result.append([shop, movie])

        return result