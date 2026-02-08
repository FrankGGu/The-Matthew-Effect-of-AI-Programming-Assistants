use std::collections::{BinaryHeap, HashMap, HashSet};

#[derive(Eq, PartialEq, Clone)]
struct Rental {
    movie: i32,
    shop: i32,
    price: i32,
}

impl Ord for Rental {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.price.cmp(&self.price).then_with(|| other.shop.cmp(&self.shop)).then_with(|| other.movie.cmp(&self.movie))
    }
}

impl PartialOrd for Rental {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

struct MovieRentingSystem {
    prices: HashMap<(i32, i32), i32>,
    rented: HashMap<i32, HashSet<i32>>,
    available: HashMap<(i32, i32), i32>,
}

impl MovieRentingSystem {
    fn new(n: i32, entries: Vec<Vec<i32>>) -> Self {
        let mut prices = HashMap::new();
        let mut rented = HashMap::new();
        let mut available = HashMap::new();
        for entry in entries {
            let shop = entry[0];
            let movie = entry[1];
            let price = entry[2];
            prices.insert((shop, movie), price);
            available.insert((shop, movie), price);
        }
        MovieRentingSystem {
            prices,
            rented,
            available,
        }
    }

    fn search(&self, movie: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut shops: Vec<i32> = self.prices.iter()
            .filter(|(&(shop, m), _)| *m == movie && self.available.contains_key(&(shop, movie)))
            .map(|(&(shop, _), _)| shop)
            .collect();
        shops.sort();
        for shop in shops.iter().take(5) {
            result.push(vec![*shop, movie]);
        }
        result
    }

    fn rent(&mut self, shop: i32, movie: i32) {
        self.available.remove(&(shop, movie));
        self.rented.entry(shop).or_insert(HashSet::new()).insert(movie);
    }

    fn drop(&mut self, shop: i32, movie: i32) {
        let price = *self.prices.get(&(shop, movie)).unwrap();
        self.available.insert((shop, movie), price);
        self.rented.get_mut(&shop).unwrap().remove(&movie);
    }

    fn report(&self) -> Vec<Vec<i32>> {
        let mut rentals: BinaryHeap<Rental> = BinaryHeap::new();
        for (&(shop, movie), &price) in self.prices.iter() {
            if !self.available.contains_key(&(shop, movie)) {
                rentals.push(Rental { movie, shop, price });
            }
        }
        let mut result = Vec::new();
        for _ in 0..std::cmp::min(5, rentals.len()) {
            let rental = rentals.pop().unwrap();
            result.push(vec![rental.shop, rental.movie]);
        }
        result
    }
}