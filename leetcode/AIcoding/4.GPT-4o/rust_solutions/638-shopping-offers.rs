impl Solution {
    pub fn shopping_offers(price: Vec<i32>, special: Vec<Vec<i32>>, needs: Vec<i32>) -> i32 {
        let mut min_cost = Self::calculate_cost(&price, &needs);
        for s in special {
            let mut new_needs = needs.clone();
            let mut valid = true;
            for i in 0..new_needs.len() {
                new_needs[i] -= s[i];
                if new_needs[i] < 0 {
                    valid = false;
                    break;
                }
            }
            if valid {
                min_cost = min_cost.min(s.last().unwrap() + Self::shopping_offers(price.clone(), special.clone(), new_needs));
            }
        }
        min_cost
    }

    fn calculate_cost(price: &Vec<i32>, needs: &Vec<i32>) -> i32 {
        price.iter().zip(needs).map(|(p, n)| p * n).sum()
    }
}