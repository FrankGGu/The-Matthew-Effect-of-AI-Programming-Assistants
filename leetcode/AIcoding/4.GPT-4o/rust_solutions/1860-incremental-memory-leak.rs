pub fn incremental_memory_leak(budget: i32) -> Vec<i32> {
    let mut memory = 0;
    let mut day = 1;

    while budget >= memory + day {
        budget -= memory + day;
        memory += day;
        day += 1;
    }

    vec![day, memory + budget]
}