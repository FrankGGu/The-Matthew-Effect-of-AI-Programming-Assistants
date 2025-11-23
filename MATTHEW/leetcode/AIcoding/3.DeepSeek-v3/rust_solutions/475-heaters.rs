impl Solution {
    pub fn find_radius(houses: Vec<i32>, heaters: Vec<i32>) -> i32 {
        let mut houses = houses;
        let mut heaters = heaters;
        houses.sort();
        heaters.sort();

        let mut radius = 0;
        let mut i = 0;

        for house in houses {
            while i < heaters.len() - 1 && (heaters[i + 1] - house) <= (house - heaters[i]) {
                i += 1;
            }
            radius = radius.max((heaters[i] - house).abs());
        }

        radius
    }
}