impl Solution {
    pub fn can_place_flowers(flowerbed: Vec<i32>, n: i32) -> bool {
        let mut count = 0;
        let mut i = 0;
        let len = flowerbed.len();

        while i < len {
            if flowerbed[i] == 0 {
                let prev = if i == 0 { 0 } else { flowerbed[i - 1] };
                let next = if i == len - 1 { 0 } else { flowerbed[i + 1] };

                if prev == 0 && next == 0 {
                    count += 1;
                    i += 1; // Skip next position since we planted here
                }
            }
            i += 1;
        }

        count >= n
    }
}