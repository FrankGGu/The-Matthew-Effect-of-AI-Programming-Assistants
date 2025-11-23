pub fn min_platforms(arr: Vec<i32>, dep: Vec<i32>) -> i32 {
    let mut arr = arr;
    let mut dep = dep;
    arr.sort();
    dep.sort();

    let mut platforms_needed = 1;
    let mut result = 1;
    let (mut i, mut j) = (1, 0);

    while i < arr.len() && j < dep.len() {
        if arr[i] <= dep[j] {
            platforms_needed += 1;
            i += 1;
        } else {
            platforms_needed -= 1;
            j += 1;
        }
        result = result.max(platforms_needed);
    }

    result
}