pub fn min_hours(energy: Vec<i32>, experience: Vec<i32>) -> i32 {
    let n = energy.len();
    let mut total_hours = 0;
    let mut total_experience = 0;

    for i in 0..n {
        if energy[i] > total_hours {
            total_hours += energy[i] - total_hours;
        }
        total_experience += experience[i];
    }

    total_hours + if total_experience < n as i32 {
        n as i32 - total_experience
    } else {
        0
    }
}