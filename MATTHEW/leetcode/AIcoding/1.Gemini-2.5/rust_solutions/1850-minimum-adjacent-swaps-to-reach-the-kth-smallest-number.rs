impl Solution {
    pub fn get_min_swaps(num: String, k: i32) -> i32 {
        let original_chars: Vec<char> = num.chars().collect();
        let mut target_chars: Vec<char> = original_chars.clone();

        for _ in 0..(k - 1) {
            Self::next_permutation(&mut target_chars);
        }

        Self::count_swaps(&original_chars, &target_chars)
    }

    fn next_permutation(arr: &mut Vec<char>) -> bool {
        let n = arr.len();
        if n <= 1 {
            return false;
        }

        let mut i = n - 2;
        while i >= 0 && arr[i] >= arr[i + 1] {
            if i == 0 {
                return false;
            }
            i -= 1;
        }

        let mut j = n - 1;
        while arr[j] <= arr[i] {
            j -= 1;
        }

        arr.swap(i, j);

        arr[i + 1..].reverse();
        true
    }

    fn count_swaps(original: &Vec<char>, target: &Vec<char>) -> i32 {
        let n = original.len();
        let mut current = original.clone();
        let mut swaps = 0;

        for i in 0..n {
            if current[i] == target[i] {
                continue;
            }

            let mut j = i + 1;
            while j < n && current[j] != target[i] {
                j += 1;
            }

            for k in (i..j).rev() {
                current.swap(k, k + 1);
                swaps += 1;
            }
        }
        swaps
    }
}