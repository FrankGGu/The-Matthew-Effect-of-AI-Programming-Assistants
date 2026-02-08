impl Solution {
    pub fn array_rank_transform(arr: Vec<i32>) -> Vec<i32> {
        let mut sorted = arr.clone();
        sorted.sort_unstable();
        let mut ranks = std::collections::HashMap::new();
        let mut rank = 1;

        for &num in sorted.iter().unique() {
            ranks.insert(num, rank);
            rank += 1;
        }

        arr.iter().map(|&num| *ranks.get(&num).unwrap()).collect()
    }
}