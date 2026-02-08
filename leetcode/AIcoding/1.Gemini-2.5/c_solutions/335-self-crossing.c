#include <stdbool.h>

bool isSelfCrossing(int* distance, int distanceSize) {
    if (distanceSize <= 3) {
        return false;
    }

    for (int i = 3; i < distanceSize; ++i) {
        // Case 1: The i-th line crosses the (i-3)-th line
        // This occurs when the path turns inward and the current segment (i)
        // is long enough to cross the segment three steps back (i-3),
        // and the segment before it (i-1) is long enough to cross the segment
        // before the (i-3)-th one (i-2).
        if (distance[i] >= distance[i-2] && distance[i-1] >= distance[i-3]) {
            return true;
        }

        // Case 2: The i-th line crosses the (i-4)-th line
        // This occurs when the path has "unwound" slightly, and the inner loop's
        // parallel segments (i-1 and i-3) are equal, and the current segment (i)
        // plus the segment four steps back (i-4) is long enough to cross
        // the segment two steps back (i-2).
        if (i >= 4) {
            if (distance[i-1] == distance[i-3] && distance[i] + distance[i-4] >= distance[i-2]) {
                return true;
            }
        }

        // Case 3: The i-th line crosses the (i-5)-th line
        // This is the most complex "inner spiral" crossing.
        // It requires specific conditions for the segments to align and cross.
        if (i >= 5) {
            if (distance[i-2] >= distance[i-4] &&
                distance[i-1] >= distance[i-3] - distance[i-5] &&
                distance[i] + distance[i-4] >= distance[i-2] &&
                distance[i-1] + distance[i-5] >= distance[i-3]) {
                return true;
            }
        }
    }

    return false;
}