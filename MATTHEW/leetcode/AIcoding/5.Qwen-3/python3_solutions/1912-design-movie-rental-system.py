class MovieRentalSystem:
    def __init__(self, n: int, entries: List[List[int]]):
        self.movies = defaultdict(list)
        self.rented = set()
        for entry in entries:
            movie_id, price = entry[0], entry[1]
            self.movies[movie_id].append(price)

    def search(self, movie: int) -> List[int]:
        return sorted(self.movies[movie])

    def rent(self, movie_id: int, user_id: int) -> None:
        self.rented.add((user_id, movie_id))

    def drop(self, movie_id: int, user_id: int) -> None:
        self.rented.discard((user_id, movie_id))

    def report(self) -> List[List[int]]:
        return sorted(self.rented)