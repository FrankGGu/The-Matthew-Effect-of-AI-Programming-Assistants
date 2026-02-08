var memLeak = function(memory1, memory2) {
    let time = 1;

    while (true) {
        if (memory1 >= memory2) {
            if (memory1 < time) {
                return [time, memory1, memory2];
            }
            memory1 -= time;
        } else { // memory2 > memory1
            if (memory2 < time) {
                return [time, memory1, memory2];
            }
            memory2 -= time;
        }
        time++;
    }
};