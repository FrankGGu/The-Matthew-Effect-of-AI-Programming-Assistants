use std::collections::HashMap;
use std::collections::HashSet;

struct MovieRentalSystem {
    available_movies: HashMap<i32, Vec<i32>>,
    rented_movies: HashMap<i32, HashSet<i32>>,
}

impl MovieRentalSystem {
    fn new() -> Self {
        MovieRentalSystem {
            available_movies: HashMap::new(),
            rented_movies: HashMap::new(),
        }
    }

    fn add_movie(&mut self, movie_id: i32, store_id: i32) {
        self.available_movies.entry(movie_id).or_insert_with(Vec::new).push(store_id);
    }

    fn rent_movies(&mut self, customer_id: i32, movie_ids: Vec<i32>) -> Vec<i32> {
        let mut rented = vec![];
        for &movie_id in &movie_ids {
            if let Some(stores) = self.available_movies.get_mut(&movie_id) {
                if let Some(store_id) = stores.pop() {
                    rented.push(movie_id);
                    self.rented_movies.entry(customer_id).or_insert_with(HashSet::new).insert(movie_id);
                }
            }
        }
        rented
    }

    fn return_movies(&mut self, customer_id: i32, movie_ids: Vec<i32>) {
        if let Some(rented) = self.rented_movies.get_mut(&customer_id) {
            for &movie_id in &movie_ids {
                if rented.remove(&movie_id) {
                    if let Some(stores) = self.available_movies.get_mut(&movie_id) {
                        // Here we assume that we always return to the same store
                        stores.push(customer_id);
                    }
                }
            }
        }
    }

    fn report_rented_movies(&self) -> HashMap<i32, Vec<i32>> {
        self.rented_movies.iter().map(|(&customer_id, movies)| (customer_id, movies.iter().cloned().collect())).collect()
    }
}