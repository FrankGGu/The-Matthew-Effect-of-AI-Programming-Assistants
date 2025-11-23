var transformArray = function(arr) {
    let changed = true;
    let current = [...arr];

    while (changed) {
        changed = false;
        let next = [...current];

        for (let i = 1; i < current.length - 1; i++) {
            if (current[i] < current[i - 1] && current[i] < current[i + 1]) {
                next[i]++;
                changed = true;
            } else if (current[i] > current[i - 1] && current[i] > current[i + 1]) {
                next[i]--;
                changed = true;
            }
        }

        current = next;
    }

    return current;
};