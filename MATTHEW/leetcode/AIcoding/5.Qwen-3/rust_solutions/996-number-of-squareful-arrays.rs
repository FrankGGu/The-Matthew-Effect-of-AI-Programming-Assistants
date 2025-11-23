impl Solution {

use std::collections::HashMap;

fn is_squareful(mut nums: Vec<i32>) -> bool {
    for i in 1..nums.len() {
        let diff = nums[i] - nums[i - 1];
        if diff < 0 {
            return false;
        }
        let sqrt = (diff as f64).sqrt() as i32;
        if sqrt * sqrt != diff {
            return false;
        }
    }
    true
}

fn count_permutations(nums: &[i32], used: &mut Vec<bool>, map: &mut HashMap<Vec<i32>, i32>, result: &mut i32) {
    if used.iter().all(|&b| b) {
        *result += 1;
        return;
    }

    let mut prev = None;
    for i in 0..nums.len() {
        if used[i] {
            continue;
        }
        if Some(nums[i]) == prev {
            continue;
        }
        prev = Some(nums[i]);
        used[i] = true;
        count_permutations(nums, used, map, result);
        used[i] = false;
    }
}

fn squareful_arrays(nums: &Vec<i32>) -> i32 {
    let mut count = 0;
    let mut used = vec![false; nums.len()];
    let mut map = HashMap::new();
    count_permutations(nums, &mut used, &mut map, &mut count);
    count
}

fn main() {
    let nums = vec![2, 2, 2];
    println!("{}", squareful_arrays(&nums));
}

pub fn num_squareful_servers(mut nums: Vec<i32>) -> i32 {
    use std::collections::HashSet;
    let n = nums.len();
    let mut result = 0;
    let mut visited = vec![false; n];
    let mut unique = HashSet::new();

    fn backtrack(
        nums: &Vec<i32>,
        visited: &mut Vec<bool>,
        path: &mut Vec<i32>,
        result: &mut i32,
        unique: &mut HashSet<Vec<i32>>,
    ) {
        if path.len() == nums.len() {
            let key = path.clone();
            if !unique.contains(&key) {
                *result += 1;
                unique.insert(key);
            }
            return;
        }

        for i in 0..nums.len() {
            if visited[i] {
                continue;
            }
            if path.is_empty() || is_squareful(vec![path.last().unwrap().clone(), nums[i].clone()]) {
                visited[i] = true;
                path.push(nums[i].clone());
                backtrack(nums, visited, path, result, unique);
                path.pop();
                visited[i] = false;
            }
        }
    }

    backtrack(&nums, &mut visited, &mut vec![], &mut result, &mut unique);
    result
}
}