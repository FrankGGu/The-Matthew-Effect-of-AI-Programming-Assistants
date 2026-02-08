var canVisitAllRooms = function(rooms) {
    const n = rooms.length;
    const visited = new Array(n).fill(false);
    visited[0] = true;
    const stack = [0];

    while (stack.length > 0) {
        const room = stack.pop();
        for (const key of rooms[room]) {
            if (!visited[key]) {
                visited[key] = true;
                stack.push(key);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            return false;
        }
    }

    return true;
};