impl Solution {
    pub fn can_place_flowers(flowerbed: Vec<i32>, n: i32) -> bool {
        let mut flowerbed = flowerbed;
        let mut n = n;
        let len = flowerbed.len();

        for i in 0..len {
            if n == 0 {
                return true;
            }

            if flowerbed[i] == 0 {
                let can_plant_left = i == 0 || flowerbed[i - 1] == 0;
                let can_plant_right = i == len - 1 || flowerbed[i + 1] == 0;

                if can_plant_left && can_plant_right {
                    flowerbed[i] = 1;
                    n -= 1;
                }
            }
        }

        n <= 0
    }
}