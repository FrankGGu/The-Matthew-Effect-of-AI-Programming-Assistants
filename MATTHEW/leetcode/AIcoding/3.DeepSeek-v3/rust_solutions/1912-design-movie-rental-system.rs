use std::collections::{BTreeSet, HashMap};

#[derive(Debug, Eq, PartialEq, Ord, PartialOrd)]
struct MovieEntry {
    price: i32,
    shop: i32,
    movie: i32,
}

struct MovieRentingSystem {
    available: HashMap<i32, BTreeSet<MovieEntry>>,
    rented: BTreeSet<MovieEntry>,
    movie_to_entries: HashMap<(i32, i32), MovieEntry>,
}

impl MovieRentingSystem {
    fn new(n: i32, entries: Vec<Vec<i32>>) -> Self {
        let mut available = HashMap::new();
        let mut movie_to_entries = HashMap::new();

        for entry in entries {
            let shop = entry[0];
            let movie = entry[1];
            let price = entry[2];
            let movie_entry = MovieEntry { price, shop, movie };

            available.entry(movie).or_insert_with(BTreeSet::new).insert(movie_entry.clone());
            movie_to_entries.insert((shop, movie), movie_entry);
        }

        MovieRentingSystem {
            available,
            rented: BTreeSet::new(),
            movie_to_entries,
        }
    }

    fn search(&self, movie: i32) -> Vec<i32> {
        if let Some(entries) = self.available.get(&movie) {
            entries.iter().take(5).map(|e| e.shop).collect()
        } else {
            Vec::new()
        }
    }

    fn rent(&mut self, shop: i32, movie: i32) {
        if let Some(entry) = self.movie_to_entries.get(&(shop, movie)) {
            if let Some(entries) = self.available.get_mut(&movie) {
                entries.remove(entry);
            }
            self.rented.insert(entry.clone());
        }
    }

    fn drop(&mut self, shop: i32, movie: i32) {
        if let Some(entry) = self.movie_to_entries.get(&(shop, movie)) {
            self.rented.remove(entry);
            self.available.entry(movie).or_insert_with(BTreeSet::new).insert(entry.clone());
        }
    }

    fn report(&self) -> Vec<Vec<i32>> {
        self.rented.iter().take(5).map(|e| vec![e.shop, e.movie]).collect()
    }
}