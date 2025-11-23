class MaxHeapMap {
    constructor() {
        this.map = new Map(); // height -> count
        this.currentMax = 0; // Stores the actual maximum height
    }

    add(height) {
        this.map.set(height, (this.map.get(height) || 0) + 1);
        if (height > this.currentMax) {
            this.currentMax = height;
        }
    }

    remove(height) {
        this.map.set(height, this.map.get(height) - 1);
        if (height === this.currentMax && this.map.get(height) === 0) {
            this.findNewMax();
        }
    }

    findNewMax() {
        this.currentMax = 0;
        for (const h of this.map.keys()) {
            if (this.map.get(h) > 0) {
                this.currentMax = Math.max(this.currentMax, h);
            }
        }
    }

    getMax() {
        return this.currentMax;
    }
}

var getSkyline = function(buildings) {
    const events = [];
    for (const [left, right, height] of buildings) {
        events.push([left, height, 1]); // 1 for start event
        events.push([right, height, -1]); // -1 for end event
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        if (a[2] === 1 && b[2] === 1) { 
            return b[1] - a[1]; 
        }
        if (a[2] === -1 && b[2] === -1) { 
            return a[1] - b[1]; 
        }
        return b[2] - a[2]; 
    });

    const skyline = [];
    const activeHeights = new MaxHeapMap();
    activeHeights.add(0); 

    let prevMaxHeight = 0;

    for (const [x, height, type] of events) {
        if (type === 1) { 
            activeHeights.add(height);
        } else { 
            activeHeights.remove(height);
        }

        const currentMaxHeight = activeHeights.getMax();

        if (currentMaxHeight !== prevMaxHeight) {
            skyline.push([x, currentMaxHeight]);
            prevMaxHeight = currentMaxHeight;
        }
    }

    return skyline;
};