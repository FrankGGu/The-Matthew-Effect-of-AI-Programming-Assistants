class MovieRentalSystem {
    constructor(movieList) {
        this.movies = new Map();
        this.rentedMovies = new Set();
        for (const [movieId, count] of movieList) {
            this.movies.set(movieId, count);
        }
    }

    rent(movieId) {
        if (this.movies.has(movieId) && this.movies.get(movieId) > 0) {
            this.movies.set(movieId, this.movies.get(movieId) - 1);
            this.rentedMovies.add(movieId);
            return true;
        }
        return false;
    }

    return(movieId) {
        if (this.rentedMovies.has(movieId)) {
            this.movies.set(movieId, this.movies.get(movieId) + 1);
            this.rentedMovies.delete(movieId);
            return true;
        }
        return false;
    }

    countAvailable(movieId) {
        return this.movies.get(movieId) || 0;
    }
}