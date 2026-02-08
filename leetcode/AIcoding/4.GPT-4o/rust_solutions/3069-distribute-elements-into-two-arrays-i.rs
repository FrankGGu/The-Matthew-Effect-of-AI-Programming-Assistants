pub fn distribute_array(nums: Vec<i32>) -> Vec<Vec<i32>> {
    let mut counts = vec![0; 101];
    for &num in &nums {
        counts[num as usize] += 1;
    }

    let mut result = vec![Vec::new(), Vec::new()];
    let mut index = 0;

    for i in 0..101 {
        while counts[i] > 0 {
            result[index].push(i as i32);
            counts[i] -= 1;
            index ^= 1;
        }
    }

    result
}