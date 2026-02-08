const obj = {
  value: 1,
  increment: function() {
    this.value += 1;
    return this;
  },
  add: function(num) {
    this.value += num;
    return this;
  },
  getValue: function() {
    return this.value;
  }
};

console.log(obj.increment().add(5).getValue()); // 输出 7
```

你的任务是实现一个 `Calculator` 类，支持以下方法链式调用：

- `add(num)` - 将 `num` 加到当前结果上，并返回 `this`。
- `subtract(num)` - 从当前结果中减去 `num`，并返回 `this`。
- `multiply(num)` - 将当前结果乘以 `num`，并返回 `this`。
- `divide(num)` - 将当前结果除以 `num`，并返回 `this`。
- `power(num)` - 将当前结果求 `num` 次幂，并返回 `this`。
- `getResult()` - 返回计算结果。

初始结果值为 0。

以下是可直接在 LeetCode 平台上运行的 JavaScript 解决方案代码：

```javascript
class Calculator {
  constructor() {
    this.result = 0;
  }

  add(num) {
    this.result += num;
    return this;
  }

  subtract(num) {
    this.result -= num;
    return this;
  }

  multiply(num) {
    this.result *= num;
    return this;
  }

  divide(num) {
    this.result /= num;
    return this;
  }

  power(num) {
    this.result **= num;
    return this;
  }

  getResult() {
    return this.result;
  }
}