function memLeak(memory1, memory2) {
    let time = 0;
    while (memory1 > time || memory2 > time) {
        if (memory1 > memory2) {
            memory1 -= ++time;
        } else {
            memory2 -= ++time;
        }
    }
    return [time, memory1, memory2];
}