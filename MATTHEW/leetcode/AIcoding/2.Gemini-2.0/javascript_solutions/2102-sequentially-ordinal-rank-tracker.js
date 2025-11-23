class SORTracker {
  constructor() {
    this.heap = [];
    this.i = 0;
  }

  add(name, score) {
    this.heap.push({ name, score });
    this.heap.sort((a, b) => {
      if (a.score !== b.score) {
        return b.score - a.score;
      }
      return a.name.localeCompare(b.name);
    });
  }

  get() {
    const result = this.heap[this.i].name;
    this.i++;
    return result;
  }
}