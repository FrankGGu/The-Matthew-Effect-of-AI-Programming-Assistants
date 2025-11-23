pub fn can_transform(arr: Vec<i32>, target: Vec<i32>) -> bool {
    let n = arr.len();
    let mut count_arr = vec![0; 1001];
    let mut count_target = vec![0; 1001];

    for &num in &arr {
        count_arr[num as usize] += 1;
    }

    for &num in &target {
        count_target[num as usize] += 1;
    }

    for i in 0..1001 {
        if count_arr[i] != count_target[i] {
            return false;
        }
    }

    let mut arr_pos: Vec<_> = arr.iter().enumerate().filter(|&(_, &x)| x != 0).collect();
    let mut target_pos: Vec<_> = target.iter().enumerate().filter(|&(_, &x)| x != 0).collect();

    arr_pos.sort_by_key(|&(_, &x)| x);
    target_pos.sort_by_key(|&(_, &x)| x);

    for (a, t) in arr_pos.iter().zip(target_pos.iter()) {
        if a.1 != t.1 {
            return false;
        }
        if a.0 > t.0 {
            return false;
        }
    }

    true
}