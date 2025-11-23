class MovieRentingSystem {
    constructor(n, entries) {
        this.n = n;
        this.movies = new Map();
        this.rented = new Set();
        this.shopMoviePrices = new Map();

        for (const [shop, movie, price] of entries) {
            if (!this.movies.has(movie)) {
                this.movies.set(movie, []);
            }
            this.movies.get(movie).push([shop, price]);

            if (!this.shopMoviePrices.has(shop)) {
                this.shopMoviePrices.set(shop, new Map());
            }
            this.shopMoviePrices.get(shop).set(movie, price);
        }

        for (const movie of this.movies.keys()) {
            this.movies.get(movie).sort((a, b) => a[1] - b[1] || a[0] - b[0]);
        }
    }

    search(movie) {
        if (!this.movies.has(movie)) {
            return [];
        }

        const availableShops = [];
        for (const [shop, price] of this.movies.get(movie)) {
            if (!this.rented.has(`${shop}-${movie}`)) {
                availableShops.push(shop);
            }
            if (availableShops.length === 5) {
                break;
            }
        }

        return availableShops;
    }

    rent(shop, movie) {
        this.rented.add(`${shop}-${movie}`);
    }

    drop(shop, movie) {
        this.rented.delete(`${shop}-${movie}`);
    }

    report() {
        const rentedMovies = [];
        for (const rentedMovie of this.rented) {
            const [shop, movie] = rentedMovie.split("-");
            rentedMovies.push([parseInt(shop), parseInt(movie), this.shopMoviePrices.get(parseInt(shop)).get(parseInt(movie))]);
        }

        rentedMovies.sort((a, b) => a[2] - b[2] || a[0] - b[0] || a[1] - b[1]);

        const result = [];
        for (let i = 0; i < Math.min(10, rentedMovies.length); i++) {
            result.push([rentedMovies[i][0], rentedMovies[i][1]]);
        }

        return result;
    }
}