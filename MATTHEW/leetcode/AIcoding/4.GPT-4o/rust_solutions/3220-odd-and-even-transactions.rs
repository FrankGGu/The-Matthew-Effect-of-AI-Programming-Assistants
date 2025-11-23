pub fn odd_even_jumps(arr: Vec<i32>) -> i32 {
    let n = arr.len();
    if n == 1 { return 1; }

    let mut odd = vec![false; n];
    let mut even = vec![false; n];
    odd[n - 1] = true;
    even[n - 1] = true;

    let mut next_odd = vec![(0, 0); n];
    let mut next_even = vec![(0, 0); n];

    let mut sorted_odd = vec![];
    let mut sorted_even = vec![];

    for i in (0..n).rev() {
        next_odd[i] = (arr[i], i);
        next_even[i] = (arr[i], i);

        if let Some(&(val, idx)) = sorted_even.iter().filter(|&&(_, idx)| idx > i).min() {
            if val >= arr[i] {
                odd[i] = true;
            }
        }

        if let Some(&(val, idx)) = sorted_odd.iter().filter(|&&(_, idx)| idx > i).min() {
            if val <= arr[i] {
                even[i] = true;
            }
        }

        sorted_odd.push((arr[i], i));
        sorted_even.push((arr[i], i));
    }

    sorted_odd.sort_unstable();
    sorted_even.sort_unstable();

    let mut result = 0;
    for i in 0..n {
        if odd[i] {
            result += 1;
        }
        if even[i] {
            result += 1;
        }
    }

    result
}