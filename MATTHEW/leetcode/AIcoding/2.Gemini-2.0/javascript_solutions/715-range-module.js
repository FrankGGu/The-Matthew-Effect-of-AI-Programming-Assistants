class RangeModule {
  constructor() {
    this.intervals = [];
  }

  addRange(left, right) {
    let newInterval = [left, right];
    let result = [];
    let i = 0;
    while (i < this.intervals.length && this.intervals[i][1] < newInterval[0]) {
      result.push(this.intervals[i]);
      i++;
    }

    while (i < this.intervals.length && this.intervals[i][0] <= newInterval[1]) {
      newInterval[0] = Math.min(newInterval[0], this.intervals[i][0]);
      newInterval[1] = Math.max(newInterval[1], this.intervals[i][1]);
      i++;
    }

    result.push(newInterval);

    while (i < this.intervals.length) {
      result.push(this.intervals[i]);
      i++;
    }

    this.intervals = result;
  }

  queryRange(left, right) {
    for (let interval of this.intervals) {
      if (interval[0] <= left && right <= interval[1]) {
        return true;
      }
    }
    return false;
  }

  removeRange(left, right) {
    let result = [];
    for (let interval of this.intervals) {
      if (interval[1] <= left || interval[0] >= right) {
        result.push(interval);
      } else {
        if (interval[0] < left) {
          result.push([interval[0], left]);
        }
        if (interval[1] > right) {
          result.push([right, interval[1]]);
        }
      }
    }
    this.intervals = result;
  }
}