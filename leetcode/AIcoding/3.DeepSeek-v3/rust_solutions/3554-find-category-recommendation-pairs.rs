use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_recommendation_pairs(friendship: Vec<Vec<i32>>, likes: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut user_friends: HashMap<i32, HashSet<i32>> = HashMap::new();
        let mut user_likes: HashMap<i32, HashSet<i32>> = HashMap::new();

        for f in friendship {
            let u1 = f[0];
            let u2 = f[1];
            user_friends.entry(u1).or_default().insert(u2);
            user_friends.entry(u2).or_default().insert(u1);
        }

        for l in likes {
            let user = l[0];
            let category = l[1];
            user_likes.entry(user).or_default().insert(category);
        }

        let mut result = Vec::new();
        let mut seen = HashSet::new();

        for (&u1, friends) in &user_friends {
            for &u2 in friends {
                if u1 >= u2 || !user_likes.contains_key(&u1) || !user_likes.contains_key(&u2) {
                    continue;
                }
                let likes1 = &user_likes[&u1];
                let likes2 = &user_likes[&u2];
                let common_categories: Vec<_> = likes1.intersection(likes2).cloned().collect();
                if !common_categories.is_empty() {
                    let pair = vec![u1, u2];
                    let reverse_pair = vec![u2, u1];
                    if !seen.contains(&pair) && !seen.contains(&reverse_pair) {
                        result.push(pair.clone());
                        seen.insert(pair);
                    }
                }
            }
        }

        result.sort();
        result
    }
}