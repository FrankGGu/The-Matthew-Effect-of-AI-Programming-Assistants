function memLeak(memory1, memory2) {
    let time = 1;
    while (memory1 >= time || memory2 >= time) {
        if (memory1 >= memory2) {
            memory1 -= time;
        } else {
            memory2 -= time;
        }
        time++;
    }
    return [time - 1, memory1, memory2];
}