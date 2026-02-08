pub fn find_in_mountain_array(target: i32, mountain_arr: &Vec<i32>) -> i32 {
    let n = mountain_arr.len();

    let peak = find_peak(mountain_arr, 0, n - 1);

    let left_result = binary_search(mountain_arr, 0, peak, target, true);
    if left_result != -1 {
        return left_result;
    }

    binary_search(mountain_arr, peak + 1, n - 1, target, false)
}

fn find_peak(mountain_arr: &Vec<i32>, low: usize, high: usize) -> usize {
    let mut low = low;
    let mut high = high;
    while low < high {
        let mid = low + (high - low) / 2;
        if mountain_arr[mid] < mountain_arr[mid + 1] {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    low
}

fn binary_search(mountain_arr: &Vec<i32>, low: usize, high: usize, target: i32, asc: bool) -> i32 {
    let mut low = low;
    let mut high = high;
    while low <= high {
        let mid = low + (high - low) / 2;
        if mountain_arr[mid] == target {
            return mid as i32;
        }
        if asc {
            if mountain_arr[mid] < target {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        } else {
            if mountain_arr[mid] > target {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
    }
    -1
}