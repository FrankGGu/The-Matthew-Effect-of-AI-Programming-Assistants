class Queue {
    constructor() {
        this.data = {};
        this.head = 0;
        this.tail = 0;
    }

    enqueue(element) {
        this.data[this.tail] = element;
        this.tail++;
    }

    dequeue() {
        if (this.head === this.tail) {
            return undefined;
        }
        const element = this.data[this.head];
        delete this.data[this.head];
        this.head++;
        return element;
    }

    isEmpty() {
        return this.head === this.tail;
    }
}

var isEscapePossible = function(blocked, source, target) {
    const MAX_COORD = 1000000;
    const MAX_VISIT = 200 * 200;

    const blockedSet = new Set();
    for (const [r, c] of blocked) {
        blockedSet.add(`${r},${c}`);
    }

    const dr = [0, 0, 1, -1];
    const dc = [1, -1, 0, 0];

    const bfs = (start, target, blockedCells) => {
        const queue = new Queue();
        queue.enqueue([start[0], start[1]]);
        const visited = new Set();
        visited.add(`${start[0]},${start[1]}`);
        let count = 0;

        while (!queue.isEmpty()) {
            const [r, c] = queue.dequeue();
            count++;

            if (count > MAX_VISIT) {
                return true;
            }

            if (r === target[0] && c === target[1]) {
                return true;
            }

            for (let i = 0; i < 4; i++) {
                const nr = r + dr[i];
                const nc = c + dc[i];

                if (nr < 0 || nr >= MAX_COORD || nc < 0 || nc >= MAX_COORD) {
                    continue;
                }

                const nextCellKey = `${nr},${nc}`;

                if (blockedCells.has(nextCellKey) || visited.has(nextCellKey)) {
                    continue;
                }

                visited.add(nextCellKey);
                queue.enqueue([nr, nc]);
            }
        }
        return false;
    };

    return bfs(source, target, blockedSet) && bfs(target, source, blockedSet);
};