use std::collections::HashMap;

impl Solution {
    pub fn shopping_offers(price: Vec<i32>, special: Vec<Vec<i32>>, needs: Vec<i32>) -> i32 {
        let mut memo: HashMap<Vec<i32>, i32> = HashMap::new();

        fn solve(price: &Vec<i32>, special: &Vec<Vec<i32>>, needs: &Vec<i32>, memo: &mut HashMap<Vec<i32>, i32>) -> i32 {
            if memo.contains_key(needs) {
                return *memo.get(needs).unwrap();
            }

            let mut direct_buy = 0;
            for i in 0..needs.len() {
                direct_buy += price[i] * needs[i];
            }

            let mut min_cost = direct_buy;

            for offer in special {
                let mut new_needs = needs.clone();
                let mut valid = true;

                for i in 0..needs.len() {
                    new_needs[i] -= offer[i];
                    if new_needs[i] < 0 {
                        valid = false;
                        break;
                    }
                }

                if valid {
                    min_cost = min_cost.min(offer.last().unwrap() + solve(price, special, &new_needs, memo));
                }
            }

            memo.insert(needs.clone(), min_cost);
            min_cost
        }

        solve(&price, &special, &needs, &mut memo)
    }
}