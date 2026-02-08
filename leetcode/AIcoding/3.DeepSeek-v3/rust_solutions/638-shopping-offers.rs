impl Solution {
    pub fn shopping_offers(price: Vec<i32>, special: Vec<Vec<i32>>, needs: Vec<i32>) -> i32 {
        let mut memo = std::collections::HashMap::new();
        Self::dfs(&price, &special, needs, &mut memo)
    }

    fn dfs(price: &[i32], special: &[Vec<i32>], needs: Vec<i32>, memo: &mut std::collections::HashMap<Vec<i32>, i32>) -> i32 {
        if let Some(&res) = memo.get(&needs) {
            return res;
        }

        let mut res = needs.iter().enumerate().map(|(i, &n)| n * price[i]).sum();

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
                res = res.min(offer.last().unwrap() + Self::dfs(price, special, new_needs, memo));
            }
        }

        memo.insert(needs, res);
        res
    }
}