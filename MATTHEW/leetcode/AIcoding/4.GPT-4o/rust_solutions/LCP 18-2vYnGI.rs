pub fn num_combinations(num_buns: i32, num_required: i32) -> Vec<i32> {
    let mut result = vec![0; num_buns as usize];
    if num_required == 0 {
        return vec![1; num_buns as usize];
    }
    let total_combinations = 1 << num_buns;
    let mut combinations = vec![0; total_combinations as usize];
    for i in 0..total_combinations {
        let count = i.count_ones() as usize;
        if count > 0 && count <= num_buns as usize {
            combinations[count] += 1;
        }
    }
    for i in 1..=num_buns as usize {
        if i <= num_required as usize {
            result[i - 1] = combinations[i] * combinations[num_required as usize - i];
        }
    }
    result
}