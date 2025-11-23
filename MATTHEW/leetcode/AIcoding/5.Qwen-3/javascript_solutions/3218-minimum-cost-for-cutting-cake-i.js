function minCost(h, v) {
    let cost = 0;
    let hCount = 1;
    let vCount = 1;

    while (h > 0 || v > 0) {
        if (h > 0 && v > 0) {
            if (h <= v) {
                cost += h * vCount;
                h--;
                hCount++;
            } else {
                cost += v * hCount;
                v--;
                vCount++;
            }
        } else if (h > 0) {
            cost += h * vCount;
            h--;
            hCount++;
        } else {
            cost += v * hCount;
            v--;
            vCount++;
        }
    }

    return cost;
}