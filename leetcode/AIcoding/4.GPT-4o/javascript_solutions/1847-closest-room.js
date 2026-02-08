var closestRoom = function(rooms, queries) {
    const n = rooms.length;
    const queryResults = new Array(queries.length);
    const queriesWithIndex = queries.map((query, index) => [query[0], query[1], index]);
    queriesWithIndex.sort((a, b) => b[1] - a[1]);
    const roomSet = new Set();

    let j = 0;

    for (let k = 0; k < queriesWithIndex.length; k++) {
        const [roomId, minSize, queryIndex] = queriesWithIndex[k];

        while (j < n && rooms[j][1] < minSize) {
            roomSet.delete(rooms[j][0]);
            j++;
        }

        if (j < n) {
            roomSet.add(roomId);
        }

        let closest = -1;
        let closestDiff = Infinity;

        for (const room of roomSet) {
            const diff = Math.abs(room - roomId);
            if (diff < closestDiff) {
                closestDiff = diff;
                closest = room;
            }
        }

        queryResults[queryIndex] = closest;
    }

    return queryResults;
};