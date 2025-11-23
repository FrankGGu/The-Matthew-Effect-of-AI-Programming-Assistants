var closestRoom = function(rooms, queries) {
    rooms.sort((a, b) => a[1] - b[1]);
    const sortedQueries = queries.map((q, i) => [...q, i]).sort((a, b) => a[1] - b[1]);
    const res = new Array(queries.length).fill(-1);
    const roomIds = [];
    let ptr = rooms.length - 1;

    for (let i = sortedQueries.length - 1; i >= 0; i--) {
        const [preferred, minSize, originalIdx] = sortedQueries[i];
        while (ptr >= 0 && rooms[ptr][1] >= minSize) {
            insertSorted(roomIds, rooms[ptr][0]);
            ptr--;
        }
        if (roomIds.length === 0) continue;
        let left = 0, right = roomIds.length - 1, bestIdx = 0;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (roomIds[mid] >= preferred) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        const candidates = [];
        if (left < roomIds.length) candidates.push(roomIds[left]);
        if (left > 0) candidates.push(roomIds[left - 1]);
        let minDiff = Infinity, bestId = -1;
        for (const id of candidates) {
            const diff = Math.abs(id - preferred);
            if (diff < minDiff || (diff === minDiff && id < bestId)) {
                minDiff = diff;
                bestId = id;
            }
        }
        res[originalIdx] = bestId;
    }
    return res;
};

function insertSorted(arr, num) {
    let left = 0, right = arr.length - 1;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < num) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    arr.splice(left, 0, num);
}