var closestRoom = function(rooms, queries) {
    rooms.sort((a, b) => b[1] - a[1]);
    const n = queries.length;
    const m = rooms.length;
    const result = new Array(n);
    const queryIndices = Array.from({ length: n }, (_, i) => i);
    queryIndices.sort((i, j) => queries[j][1] - queries[i][1]);
    const availableRooms = new Set();
    let roomIndex = 0;

    for (const queryIndex of queryIndices) {
        const [preferredRoom, minSize] = queries[queryIndex];
        while (roomIndex < m && rooms[roomIndex][1] >= minSize) {
            availableRooms.add(rooms[roomIndex][0]);
            roomIndex++;
        }

        if (availableRooms.size === 0) {
            result[queryIndex] = -1;
        } else {
            let closestRoomId = -1;
            let minDiff = Infinity;
            for (const roomId of availableRooms) {
                const diff = Math.abs(roomId - preferredRoom);
                if (diff < minDiff) {
                    minDiff = diff;
                    closestRoomId = roomId;
                }
            }
            result[queryIndex] = closestRoomId;
        }
    }

    return result;
};