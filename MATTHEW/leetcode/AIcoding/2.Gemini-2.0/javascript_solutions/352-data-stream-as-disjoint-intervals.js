class SummaryRanges {
  constructor() {
    this.intervals = [];
  }

  addNum(value) {
    let newInterval = [value, value];
    let merged = [];
    let i = 0;

    while (i < this.intervals.length && this.intervals[i][1] < newInterval[0] - 1) {
      merged.push(this.intervals[i]);
      i++;
    }

    while (i < this.intervals.length && this.intervals[i][0] <= newInterval[1] + 1) {
      newInterval[0] = Math.min(newInterval[0], this.intervals[i][0]);
      newInterval[1] = Math.max(newInterval[1], this.intervals[i][1]);
      i++;
    }

    merged.push(newInterval);

    while (i < this.intervals.length) {
      merged.push(this.intervals[i]);
      i++;
    }

    this.intervals = merged;
  }

  getIntervals() {
    return this.intervals;
  }
}