class MyCalendarThree {
  constructor() {
    this.timeline = new Map();
  }

  book(start, end) {
    this.timeline.set(start, (this.timeline.get(start) || 0) + 1);
    this.timeline.set(end, (this.timeline.get(end) || 0) - 1);

    let active = 0;
    let maxActive = 0;
    const sortedKeys = Array.from(this.timeline.keys()).sort((a, b) => a - b);

    for (const key of sortedKeys) {
      active += this.timeline.get(key);
      maxActive = Math.max(maxActive, active);
    }

    return maxActive;
  }
}