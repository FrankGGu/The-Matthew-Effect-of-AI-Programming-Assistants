impl Solution {
    pub fn odd_even_jumps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut can_reach_odd = vec![false; n];
        let mut can_reach_even = vec![false; n];
        can_reach_odd[n - 1] = true;
        can_reach_even[n - 1] = true;

        let mut odd_jump_indices: Vec<_> = (0..n).collect();
        let mut even_jump_indices: Vec<_> = (0..n).collect();

        odd_jump_indices.sort_by_key(|&i| arr[i]);
        even_jump_indices.sort_by_key(|&i| std::cmp::Reverse(arr[i]));

        for &index in &odd_jump_indices {
            for i in (index + 1)..n {
                if arr[i] >= arr[index] {
                    can_reach_odd[index] = can_reach_odd[index] || can_reach_even[i];
                    break;
                }
            }
        }

        for &index in &even_jump_indices {
            for i in (index + 1)..n {
                if arr[i] <= arr[index] {
                    can_reach_even[index] = can_reach_even[index] || can_reach_odd[i];
                    break;
                }
            }
        }

        can_reach_odd.iter().filter(|&&x| x).count() as i32 + can_reach_even.iter().filter(|&&x| x).count() as i32
    }
}