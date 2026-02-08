class Deque {
    constructor() {
        this.front = [];
        this.back = [];
    }

    pushFront(item) {
        this.front.push(item);
    }

    pushBack(item) {
        this.back.push(item);
    }

    popFront() {
        if (this.front.length > 0) {
            return this.front.pop();
        }
        if (this.back.length === 0) {
            return undefined;
        }
        this.front = this.back.reverse();
        this.back = [];
        return this.front.pop();
    }

    isEmpty() {
        return this.front.length === 0 && this.back.length === 0;
    }
}

var minPushBox = function(grid) {
    const R = grid.length;
    const C = grid[0].length;

    let startBoxR, startBoxC, startPlayerR, startPlayerC, targetR, targetC;

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (grid[r][c] === 'B') {
                startBoxR = r;
                startBoxC = c;
            } else if (grid[r][c] === 'S') {
                startPlayerR = r;
                startPlayerC = c;
            } else if (grid[r][c] === 'T') {
                targetR = r;
                targetC = c;
            }
        }
    }

    const dist = Array(R).fill(0).map(() => Array(C).fill(0).map(() => Array(R).fill(0).map(() => Array(C).fill(Infinity))));

    const deque = new Deque();

    dist[startBoxR][startBoxC][startPlayerR][startPlayerC] = 0;
    deque.pushFront([startBoxR, startBoxC, startPlayerR, startPlayerC]);

    const dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (!deque.isEmpty()) {
        const [br, bc, pr, pc] = deque.popFront();
        const currentPushes = dist[br][bc][pr][pc];

        if (br === targetR && bc === targetC) {
            return currentPushes;
        }

        // Player moves (0-cost)
        for (const [dr, dc] of dirs) {
            const npr = pr + dr;
            const npc = pc + dc;

            if (npr < 0 || npr >= R || npc < 0 || npc >= C) continue;
            if (grid[npr][npc] === '#') continue;
            if (npr === br && npc === bc) continue;

            if (currentPushes < dist[br][bc][npr][npc]) {
                dist[br][bc][npr][npc] = currentPushes;
                deque.pushFront([br, bc, npr, npc]);
            }
        }

        // Box pushes (1-cost)
        for (const [dr, dc] of dirs) {
            const playerPushFromR = br - dr;
            const playerPushFromC = bc - dc;

            if (pr === playerPushFromR && pc === playerPushFromC) {
                const nextBoxR = br + dr;
                const nextBoxC = bc + dc;

                if (nextBoxR < 0 || nextBoxR >= R || nextBoxC < 0 || nextBoxC >= C) continue;
                if (grid[nextBoxR][nextBoxC] === '#') continue;

                const nextPlayerR = br;
                const nextPlayerC = bc;

                const newPushes = currentPushes + 1;

                if (newPushes < dist[nextBoxR][nextBoxC][nextPlayerR][nextPlayerC]) {
                    dist[nextBoxR][nextBoxC][nextPlayerR][nextPlayerC] = newPushes;
                    deque.pushBack([nextBoxR, nextBoxC, nextPlayerR, nextPlayerC]);
                }
            }
        }
    }

    return -1;
};