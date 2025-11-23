var SORTracker = function() {
    this.heap = [];
    this.size = 0;
};

SORTracker.prototype.insert = function(name, score) {
    this.heap.push({ name, score });
    this.size++;
    let i = this.size - 1;
    while (i > 0) {
        let parent = Math.floor((i - 1) / 2);
        if (this.heap[parent].score > this.heap[i].score || 
            (this.heap[parent].score === this.heap[i].score && this.heap[parent].name <= this.heap[i].name)) {
            break;
        }
        [this.heap[i], this.heap[parent]] = [this.heap[parent], this.heap[i]];
        i = parent;
    }
};

SORTracker.prototype.get = function() {
    let result = this.heap[0].name;
    this.heap[0] = this.heap[this.size - 1];
    this.size--;
    let i = 0;
    while (true) {
        let left = 2 * i + 1;
        let right = 2 * i + 2;
        let smallest = i;
        if (left < this.size && 
            (this.heap[left].score < this.heap[smallest].score || 
             (this.heap[left].score === this.heap[smallest].score && this.heap[left].name < this.heap[smallest].name))) {
            smallest = left;
        }
        if (right < this.size && 
            (this.heap[right].score < this.heap[smallest].score || 
             (this.heap[right].score === this.heap[smallest].score && this.heap[right].name < this.heap[smallest].name))) {
            smallest = right;
        }
        if (smallest === i) break;
        [this.heap[i], this.heap[smallest]] = [this.heap[smallest], this.heap[i]];
        i = smallest;
    }
    return result;
};