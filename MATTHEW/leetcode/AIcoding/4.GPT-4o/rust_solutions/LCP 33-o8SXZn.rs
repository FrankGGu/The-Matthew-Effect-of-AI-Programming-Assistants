pub fn trap(height: Vec<i32>) -> i32 {
    let n = height.len();
    if n == 0 { return 0; }
    let mut left = vec![0; n];
    let mut right = vec![0; n];
    left[0] = height[0];
    right[n - 1] = height[n - 1];

    for i in 1..n {
        left[i] = left[i - 1].max(height[i]);
    }
    for i in (0..n - 1).rev() {
        right[i] = right[i + 1].max(height[i]);
    }

    let mut total_water = 0;
    for i in 0..n {
        total_water += left[i].min(right[i]) - height[i];
    }
    total_water
}