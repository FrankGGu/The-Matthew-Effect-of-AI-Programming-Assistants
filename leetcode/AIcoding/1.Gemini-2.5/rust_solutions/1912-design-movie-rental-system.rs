use std::collections::{HashMap, BTreeSet};

struct MovieRenter {
    // Stores the price for a given (shop_id, movie_id) pair.
    prices: HashMap<(i32, i32), i32>,
    // Stores available movies, grouped by movie_id.
    // Each BTreeSet contains (price, shop_id) tuples, sorted by price then shop_id.
    available_movies: HashMap<i32, BTreeSet<(i32, i32)>>,
    // Stores currently rented movies.
    // Contains (price, shop_id, movie_id) tuples, sorted by price, then shop_id, then movie_id.
    rented_movies: BTreeSet<(i32, i32, i32)>,
}

impl MovieRenter {
    fn new(n: i32, mut_movies: Vec<Vec<i32>>) -> Self {
        let mut prices = HashMap::new();
        let mut available_movies: HashMap<i32, BTreeSet<(i32, i32)>> = HashMap::new();

        for movie_info in mut_movies {
            let shop_id = movie_info[0];
            let movie_id = movie_info[1];
            let price = movie_info[2];

            prices.insert((shop_id, movie_id), price);
            available_movies.entry(movie_id).or_default().insert((price, shop_id));
        }

        MovieRenter {
            prices,
            available_movies,
            rented_movies: BTreeSet::new(),
        }
    }

    fn rent(&mut self, shop: i32, movie: i32) {
        let price = *self.prices.get(&(shop, movie)).unwrap();

        // Remove from available movies for the given movie_id
        self.available_movies
            .get_mut(&movie)
            .unwrap()
            .remove(&(price, shop));

        // Add to rented movies
        self.rented_movies.insert((price, shop, movie));
    }

    fn drop(&mut self, shop: i32, movie: i32) {
        let price = *self.prices.get(&(shop, movie)).unwrap();

        // Remove from rented movies
        self.rented_movies.remove(&(price, shop, movie));

        // Add back to available movies for the given movie_id
        self.available_movies
            .entry(movie)
            .or_default()
            .insert((price, shop));
    }

    fn report(&self) -> Vec<Vec<i32>> {
        self.rented_movies
            .iter()
            .take(5)
            .map(|&(_price, shop, movie)| vec![shop, movie])
            .collect()
    }

    fn search(&self, movie: i32) -> Vec<i32> {
        if let Some(shops_for_movie) = self.available_movies.get(&movie) {
            shops_for_movie
                .iter()
                .take(5)
                .map(|&(_price, shop)| shop)
                .collect()
        } else {
            Vec::new()
        }
    }
}