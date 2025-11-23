pub fn max_area(h: i32, w: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
    let mut horizontal_cuts = horizontal_cuts;
    let mut vertical_cuts = vertical_cuts;

    horizontal_cuts.sort();
    vertical_cuts.sort();

    let max_h = horizontal_cuts.iter().zip(horizontal_cuts.iter().skip(1)).map(|(a, b)| b - a).chain(std::iter::once(horizontal_cuts[0])).chain(std::iter::once(h - horizontal_cuts.last().unwrap())).max().unwrap();
    let max_w = vertical_cuts.iter().zip(vertical_cuts.iter().skip(1)).map(|(a, b)| b - a).chain(std::iter::once(vertical_cuts[0])).chain(std::iter::once(w - vertical_cuts.last().unwrap())).max().unwrap();

    ((max_h as i64) * (max_w as i64)) % 1_000_000_007 as i64 as i32
}