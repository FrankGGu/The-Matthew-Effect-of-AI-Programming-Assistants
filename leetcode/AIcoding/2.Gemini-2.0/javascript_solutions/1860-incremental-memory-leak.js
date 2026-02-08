var memLeak = function(memory1, memory2) {
    let i = 1;
    while (i <= memory1 || i <= memory2) {
        if (memory1 >= memory2) {
            if (memory1 >= i) {
                memory1 -= i;
            } else {
                break;
            }
        } else {
            if (memory2 >= i) {
                memory2 -= i;
            } else {
                break;
            }
        }
        i++;
    }
    return [i, memory1, memory2];
};