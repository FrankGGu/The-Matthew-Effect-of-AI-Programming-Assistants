class MovieRentingSystem:

    def __init__(self, capacity: int, movies: List[int], showtimes: List[List[int]]):
        self.capacity = capacity
        self.movies = {}
        self.available = {}
        self.rented = {}
        for i in range(len(movies)):
            self.movies[movies[i]] = showtimes[i]
            self.available[movies[i]] = []
            for time in showtimes[i]:
                self.available[movies[i]].append((time, movies[i]))
        self.available = sorted([(time, movie) for movie in self.available for time in self.available[movie]])

    def rent(self, movie: int, time: int) -> List[int]:
        if movie in self.available and (time, movie) in self.available[movie]:
            self.available[movie].remove((time, movie))
            if movie not in self.rented:
                self.rented[movie] = []
            self.rented[movie].append((time, movie))
            self.rented[movie] = sorted(self.rented[movie])
            return [movie]
        return []

    def drop(self, movie: int, time: int) -> None:
        if movie in self.rented:
            self.rented[movie].remove((time, movie))
            self.available[movie].append((time, movie))
            self.available[movie] = sorted(self.available[movie])

    def report(self) -> List[List[int]]:
        result = []
        for movie in self.rented:
            for time, m in self.rented[movie]:
                result.append([movie, time])
        result.sort(key=lambda x: (x[1], x[0]))
        return result[:self.capacity]