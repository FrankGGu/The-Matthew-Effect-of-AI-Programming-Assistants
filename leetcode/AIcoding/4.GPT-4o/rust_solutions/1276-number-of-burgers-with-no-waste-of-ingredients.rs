pub fn num_of_burgers(tomatoSlices: i32, cheeseSlices: i32) -> Vec<i32> {
    let x = tomatoSlices - 2 * cheeseSlices;
    let y = 4 * cheeseSlices - tomatoSlices;

    if x < 0 || y < 0 || x % 2 != 0 || y % 2 != 0 {
        return vec![];
    }

    vec![x / 2, y / 2]
}