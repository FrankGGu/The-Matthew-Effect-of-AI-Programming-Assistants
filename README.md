# The Matthew Effect of AI Programming Assistants: A Hidden Bias in Software Evolution (ICLR 2026)

[![Conference](https://img.shields.io/badge/ICLR-2026-brightgreen)](#)
[![Paper](https://img.shields.io/badge/OpenReview-Paper-blue)](https://openreview.net/forum?id=QjkJdcbSDe)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **AI 编程助手正在加剧软件生态的“马太效应”**：热门语言/框架获得更强的 AI 支持，冷门生态则承受显著的“AI 生产力税（AI productivity tax）”。

本仓库为 ICLR 2026 接收论文 **“The Matthew Effect of AI Programming Assistants: A Hidden Bias in Software Evolution”** 的配套代码与数据（benchmark、prompt 模板、评测脚本、结果分析等），用于复现实验并便于后续研究扩展。

---

## 🔥 TL;DR（可传播版）

- 在同一套评测协议下，**语言与框架的“流行度”是 AI 编程成功率的强预测因子**，甚至往往比“模型更强/更会推理”更关键。
- 代表性结果：在最佳模型上，**Python Pass@1 = 79.81%**，而 **Erlang Pass@1 = 24.31%**，相差 **3 倍+**。
- 冷门语言/框架的失败类型更“底层”：热门语言多为 **Wrong Answer / Runtime Error**（能跑但不对），冷门语言往往大量 **Compile Error**（语法/工程化都不稳）。
- 在真实全栈场景的“Vibe Coding”迭代协议中，主流栈通常 **1–3 轮**收敛，冷门/新兴栈经常需要 **5–10 轮**甚至无法完成。

---

## 📌 研究内容概述

LLM 驱动的 AI 编程工具正在改变软件开发范式（vibe coding、agentic coding）。已有研究多聚焦 prompt 工程或单点准确率，但**生态层面的长期影响**仍缺乏系统测量。

本研究通过大规模实验回答：**AI 编程助手是否会在语言/框架层面强化“强者恒强”的生态演化？**

---

## 🧪 Benchmark & Experiments

### 1) Algorithmic Tasks（语言层面）
- 数据来源：LeetCode 公共题目
- 规模：**3,011 道题**（Easy/Medium/Hard）
- 语言：**9 种**（Python, C++, C, Java, JavaScript, Go, Rust, Erlang, Racket）
- 模型：**5 个商用闭源模型**
- 总调用：**3,011 × 9 × 5 = 135,495** 次代码生成请求
- 指标：LeetCode 在线评测，**Pass@1**（首提交通过率），并统计错误类型（Compile Error / Wrong Answer / Runtime Error 等）
<img width="513" height="288" alt="image" src="https://github.com/user-attachments/assets/680ebb0a-d9e0-45d1-944e-68e191e782a7" />

### 2) Framework Tasks（框架/技术栈层面）
- 两层任务：
  1. **17 个通用 CRUD 全栈任务**（在 6 套主流/新兴技术栈上对比）
  2. **8 个“技术路线分歧”任务**（如 API Gateway、分布式 KV、Chat Server 等，比较 mainstream/mid/niche 栈的迭代成本）
- 评测协议：**VibeCoding** —— 仅反馈原始报错信息，不做人类“帮写/帮改”，测量 AI 工具独立修复与收敛能力（以迭代轮数/是否完成为主）
<img width="517" height="287" alt="image" src="https://github.com/user-attachments/assets/b21a2b0d-e9bd-46d5-984b-4a35e46794f7" />

---

## 📊 Key Findings（核心发现）

### 语言层面：生产力鸿沟
- 最佳模型示例：**Python 79.81% vs Erlang 24.31%（Pass@1）**
- 难度越高差距越大：从 Easy 到 Hard，热门与冷门语言差距显著扩大
- 失败机制不同：冷门语言中 **Compile Error 占比极高**，体现训练数据/工具链知识覆盖不足

### 框架层面：AI 生产力税
- 17 个 CRUD 任务中，主流栈（如 Vue+Spring、React+Express、Django）更容易在少量尝试内完成
- 在技术路线分歧任务中：
  - 主流栈常 **1–2 轮**收敛
  - 冷门/新兴栈常需 **5–10 轮**甚至失败
- 这形成潜在自我强化循环：**数据更多 → AI 支持更强 → 更多人选用 → 数据更更多**
<img width="302" height="287" alt="image" src="https://github.com/user-attachments/assets/c8118d29-9ae9-43ad-a42d-27e36b699461" />

---

