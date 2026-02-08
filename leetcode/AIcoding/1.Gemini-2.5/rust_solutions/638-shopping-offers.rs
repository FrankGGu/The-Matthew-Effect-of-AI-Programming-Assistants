use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn shopping_offers(price: Vec<i32>, special: Vec<Vec<i32>>, needs: Vec<i32>) -> i32 {
        let n = price.len();
        let mut memo: HashMap<Vec<i32>, i32> = HashMap::new();

        Self::dfs(&price, &special, needs, n, &mut memo)
    }

    fn dfs(
        price: &[i32],
        special: &[Vec<i32>],
        current_needs: Vec<i32>,
        n: usize,
        memo: &mut HashMap<Vec<i32>, i32>,
    ) -> i32 {
        if let Some(&cost) = memo.get(&current_needs) {
            return cost;
        }

        let mut min_cost = 0;
        for i in 0..n {
            min_cost += current_needs[i] * price[i];
        }

        for offer in special {
            let mut next_needs = current_needs.clone();
            let mut can_apply = true;
            for i in 0..n {
                if next_needs[i] < offer[i] {
                    can_apply = false;
                    break;
                }
                next_needs[i] -= offer[i];
            }

            if can_apply {
                let offer_price = offer[n];
                min_cost = min_cost.min(offer_price + Self::dfs(price, special, next_needs, n, memo));
            }
        }

        memo.insert(current_needs, min_cost);
        min_cost
    }
}