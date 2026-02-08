int addRungs(int* rungs, int rungsSize, int dist) {
    int added_rungs = 0;
    int current_height = 0;

    for (int i = 0; i < rungsSize; i++) {
        int rung_height = rungs[i];
        int diff = rung_height - current_height;

        if (diff > dist) {
            // Calculate how many rungs are needed to bridge the gap.
            // If the difference is `diff` and max step is `dist`,
            // we need `ceil(diff / dist)` steps.
            // Since the last step is covered by `rung_height`, we need `ceil(diff / dist) - 1` additional rungs.
            // In integer arithmetic, `ceil(A / B)` can be computed as `(A + B - 1) / B`.
            // So, `(diff + dist - 1) / dist - 1` for the number of rungs to add.
            // This simplifies to `(diff - 1) / dist`.
            added_rungs += (diff - 1) / dist;
        }
        current_height = rung_height;
    }

    return added_rungs;
}