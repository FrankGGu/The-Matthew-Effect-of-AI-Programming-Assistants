impl Solution {
    pub fn three_equal_parts(arr: Vec<i32>) -> Vec<i32> {
        let ones = arr.iter().filter(|&x| *x == 1).count();
        if ones % 3 != 0 {
            return vec![-1, -1];
        }
        if ones == 0 {
            return vec![0, 2];
        }

        let k = ones / 3;
        let mut first = -1;
        let mut second = -1;
        let mut third = -1;
        let mut count = 0;

        for i in 0..arr.len() {
            if arr[i] == 1 {
                count += 1;
                if count == 1 {
                    first = i as i32;
                } else if count == k + 1 {
                    second = i as i32;
                } else if count == 2 * k + 1 {
                    third = i as i32;
                }
            }
        }

        let mut len = arr.len() as i32 - third;
        if first + len >= second || second + len >= third {
            return vec![-1, -1];
        }

        while third + len < arr.len() as i32 && arr[first as usize + len as usize] == arr[second as usize + len as usize] && arr[second as usize + len as usize] == arr[third as usize + len as usize] {
            len += 1;
        }

        len -= 1;

        if third + len == arr.len() as i32 - 1 && arr[first as usize + len as usize] == arr[second as usize + len as usize] && arr[second as usize + len as usize] == arr[third as usize + len as usize]{
            return vec![first + len, second + len + 1];
        }

        if arr[first as usize + len as usize] == arr[second as usize + len as usize] && arr[second as usize + len as usize] == arr[third as usize + len as usize] {
            return vec![first + len, second + len + 1];
        }

        let len = arr.len() as i32 - third -1;
        if first + len >= second || second + len >= third {
            return vec![-1, -1];
        }
        if arr[(first + len) as usize] != arr[(second + len) as usize] || arr[(second + len) as usize] != arr[(third + len) as usize] {
           return vec![-1, -1];
        }

        vec![-1, -1]
    }
}