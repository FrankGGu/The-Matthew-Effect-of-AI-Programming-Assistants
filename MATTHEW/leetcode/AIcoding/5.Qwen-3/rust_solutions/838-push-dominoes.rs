impl Solution {
    pub fn push_dominoes(dominoes: String) -> String {
        let mut arr = dominoes.chars().collect::<Vec<char>>();
        let n = arr.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        let mut count = 0;
        for i in 0..n {
            if arr[i] == 'R' {
                count = 1;
            } else if arr[i] == 'L' {
                count = 0;
            } else {
                if count > 0 {
                    count += 1;
                }
            }
            right[i] = count;
        }

        count = 0;
        for i in (0..n).rev() {
            if arr[i] == 'L' {
                count = 1;
            } else if arr[i] == 'R' {
                count = 0;
            } else {
                if count > 0 {
                    count += 1;
                }
            }
            left[i] = count;
        }

        for i in 0..n {
            if right[i] > 0 && left[i] > 0 {
                if right[i] < left[i] {
                    arr[i] = 'R';
                } else if left[i] < right[i] {
                    arr[i] = 'L';
                } else {
                    arr[i] = '.';
                }
            } else if right[i] > 0 {
                arr[i] = 'R';
            } else if left[i] > 0 {
                arr[i] = 'L';
            }
        }

        arr.into_iter().collect()
    }
}