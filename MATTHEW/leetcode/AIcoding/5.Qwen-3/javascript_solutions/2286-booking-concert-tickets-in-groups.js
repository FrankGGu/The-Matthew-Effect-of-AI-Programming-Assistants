function allotTickets(tickets, requests) {
    const n = tickets.length;
    const res = new Array(requests.length).fill(0);
    const events = [];

    for (let i = 0; i < requests.length; i++) {
        const [start, end, cnt] = requests[i];
        events.push([start, 'add', cnt, i]);
        events.push([end + 1, 'remove', cnt, i]);
    }

    events.sort((a, b) => a[0] - b[0] || a[1].localeCompare(b[1]));

    let ptr = 0;
    const segTree = new SegmentTree(tickets);

    for (const event of events) {
        const [pos, type, cnt, idx] = event;
        while (ptr < pos) {
            segTree.update(ptr, 1);
            ptr++;
        }
        if (type === 'add') {
            res[idx] = segTree.query(cnt);
        } else {
            segTree.update(pos - 1, -1);
        }
    }

    return res;
}

class SegmentTree {
    constructor(arr) {
        this.n = arr.length;
        this.size = 1;
        while (this.size < this.n) this.size <<= 1;
        this.tree = new Array(this.size * 2).fill(0);
        for (let i = 0; i < this.n; i++) {
            this.tree[this.size + i] = arr[i];
        }
        for (let i = this.size - 1; i > 0; i--) {
            this.tree[i] = this.tree[2 * i] + this.tree[2 * i + 1];
        }
    }

    update(pos, delta) {
        pos += this.size;
        this.tree[pos] += delta;
        for (pos >>= 1; pos >= 1; pos >>= 1) {
            this.tree[pos] = this.tree[2 * pos] + this.tree[2 * pos + 1];
        }
    }

    query(k) {
        let res = -1;
        let pos = 1;
        let left = 0;
        let right = this.size - 1;

        while (left < right) {
            const mid = (left + right) >> 1;
            if (this.tree[2 * pos] >= k) {
                pos = 2 * pos;
                right = mid;
            } else {
                k -= this.tree[2 * pos];
                pos = 2 * pos + 1;
                left = mid + 1;
            }
        }

        if (this.tree[pos] >= k) {
            res = left;
            this.update(left, -1);
        }
        return res;
    }
}