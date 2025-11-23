var minStalls = function(demands) {
    const start = [];
    const end = [];
    for (const demand of demands) {
        const [s, e] = demand.split(' ').map(Number);
        start.push(s);
        end.push(e);
    }

    start.sort((a, b) => a - b);
    end.sort((a, b) => a - b);

    let stalls = 0;
    let i = 0;
    let j = 0;

    while (i < demands.length) {
        if (start[i] < end[j]) {
            stalls++;
            i++;
        } else {
            i++;
            j++;
        }
    }

    return stalls;
};